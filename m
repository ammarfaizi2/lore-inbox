Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267736AbTB1KYf>; Fri, 28 Feb 2003 05:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267765AbTB1KYf>; Fri, 28 Feb 2003 05:24:35 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:58889 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267736AbTB1KYe>; Fri, 28 Feb 2003 05:24:34 -0500
Date: Fri, 28 Feb 2003 11:36:36 +0100
From: binary man <the_binary_man@yahoo.fr>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mouse generating two mouse click events instead of one
Message-Id: <20030228113636.5987ef86.the_binary_man@yahoo.fr>
In-Reply-To: <20030228063734.31846.qmail@linuxmail.org>
References: <20030228063734.31846.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 07:37:34 +0100
"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:

> ----- Original Message ----- 
> From: Grzegorz Jaskiewicz <gj@pointblue.com.pl> 
> Date: 27 Feb 2003 23:46:37 +0000  
> To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> 
> Subject: Re: Mouse generating two mouse click events instead of one 
>  
> > On Thu, 2003-02-27 at 22:33, Felipe Alfaro Solana wrote: 
> > this often happends when you have two inputs in XFree86 config pointing 
> > to the same device. 
>  
> But I don't... :-( 
> More ideas ;-) 
> -- 
Perhaps you use /dev/gpmdata as device for X, but you don't use "MouseSystems" as protocol ( always for X) ?
Or perhaps you use gpm, but it isn't correctly configured ? Does your mouse works correctly on console ?
Or perhaps your mouse is broken ;)

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
