Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTI3XEY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbTI3XDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:03:13 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:13839 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S261828AbTI3XBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:01:53 -0400
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: Simon Ask Ulsnes <simon@ulsnes.dk>
Subject: Re: Complaint: Wacom driver in 2.6
Date: Tue, 30 Sep 2003 23:19:09 +0100
User-Agent: KMail/1.5.4
References: <200309291421.45692.simon@ulsnes.dk> <200309301813.03609.gothick@gothick.org.uk> <200309302259.26652.simon@ulsnes.dk>
In-Reply-To: <200309302259.26652.simon@ulsnes.dk>
Cc: linux-kernel@vger.kernel.org
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309302319.09503.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 Sep 2003 21:59, Simon Ask Ulsnes wrote:
> One funny thing: I haven't got the mousedev module loaded at all, only
> evdev, hid and wacom.

Mousedev can only be compiled as a module if you've said yes to "Remove 
Kernel Features" from the General Setup screen (usually used for lightweight 
embedded kernels.)   Otherwise it's always compiled straight in.

> The reason I am not satisfied with things the way they are is that it
> feels like somehow the dimensions on the tablet don't fit with the screen.
> E.g., my mouse or pen might hit an edge on the tablet being several
> centimeters from the edge of the screen. And mouse (not pen) movement is
> absolute, it should be relative, which is a pain in a certain place.

Hmm.  Well, I think I'll give it a go and see what I can get working; I'll 
probably want to use the pen/eraser stuff properly at some point.  Although 
I'm not drawing much any more, they do come in handy sometimes.  I'll get 
back to you after I've had a bit of a play.

> The link you provided is outdated, the newest project is on
> linuxwacom.sourceforge.net. It seems strangely stalled, though.

Thanks; I'll update my bookmarks.  It has been a while!

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
