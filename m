Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSCDPbf>; Mon, 4 Mar 2002 10:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288051AbSCDPbZ>; Mon, 4 Mar 2002 10:31:25 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:5641 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S274862AbSCDPbN>;
	Mon, 4 Mar 2002 10:31:13 -0500
Date: Mon, 4 Mar 2002 07:23:45 -0800
From: Greg KH <greg@kroah.com>
To: Anthony DeRobertis <derobert+anthony@erols.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.17 USB problems
Message-ID: <20020304152345.GA2513@kroah.com>
In-Reply-To: <7CEBD8B5-2F67-11D6-A7D0-00039355CFA6@erols.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CEBD8B5-2F67-11D6-A7D0-00039355CFA6@erols.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 04 Feb 2002 13:09:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 07:00:55AM -0500, Anthony DeRobertis wrote:
> I've got a Compaq Presario 5000US here which is having weird USB 
> errors. This machine works in Windows, so I think the hardware 
> works.

Can you try 2.4.19-pre2?  It has some USB changes that might help you
out.

thanks,

greg k-h
