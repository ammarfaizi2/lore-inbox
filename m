Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267880AbTCFHlV>; Thu, 6 Mar 2003 02:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267881AbTCFHlV>; Thu, 6 Mar 2003 02:41:21 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48135 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267880AbTCFHlU>;
	Thu, 6 Mar 2003 02:41:20 -0500
Date: Wed, 5 Mar 2003 23:42:11 -0800
From: Greg KH <greg@kroah.com>
To: dan carpenter <error27@email.com>
Cc: linux-kernel@vger.kernel.org, smatch-discuss@lists.sourceforge.net
Subject: Re: smatch update / 2.5.64 / kbugs.org
Message-ID: <20030306074211.GA719@kroah.com>
References: <20030306073727.2806.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030306073727.2806.qmail@email.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 02:37:27AM -0500, dan carpenter wrote:
> /*  
>  * Smatch is an open source c error checker based 
>  * on the papers about the Stanford Checker. 
>  * (http://smatch.sf.net)  The documentation on coding 
>  * smatch checks has been updated since my last email to 
>  * this list. 
>  *
>  */
> 
> The smatch bugs for kernel 2.5.64 are up.  The 
> new url for the smatch bug database is http://kbugs.org.  

I really appreciate the work you are doing on this project, but I have a
comment on how the output is being generated.

What I really need to know is, what are all of the reported errors in a
specific portion of the kernel tree.  If you give some way to search
based on filename and path, I think you will find a lot more people
using the results of this tool.  I know I would :)

Also, what advantage does signing up for a user account on the kbugs.org
site give you?

thanks,

greg k-h
