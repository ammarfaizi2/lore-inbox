Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266760AbSKHGaX>; Fri, 8 Nov 2002 01:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSKHGaX>; Fri, 8 Nov 2002 01:30:23 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:43503 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S266760AbSKHGaW> convert rfc822-to-8bit; Fri, 8 Nov 2002 01:30:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: David Grothe <dave@gcom.com>
Subject: Re: [PATCH] Linux-streams registration 2.5.46
Date: Fri, 8 Nov 2002 06:37:06 +0000
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <5.1.0.14.2.20021107145447.027905c8@localhost>
In-Reply-To: <5.1.0.14.2.20021107145447.027905c8@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211080637.06511.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 November 2002 21:00, David Grothe wrote:
> All:
>
> I finally have LiS running on a 2.5 kernel.  Attached is the 2.5.46 version
> of the syscall registration patch that was submitted for inclusion in the
> 2.4 kernel about a month ago.  It has been tested on an Intel platform.
>
> The patch follows inline for easy perusal and is attached as a file for
> tab-preservation.
>
> Comments welcome.  If it looks good will someone tell me to whom to direct
> it for inclusion in the kernel source?

Just a random comment, but the feature freeze was October 31st.  Is this a 
repost of something we saw before then?

Rob

-- 
http://penguicon.sf.net - Terry Pratchett, Eric Raymond, Pete Abrams, Illiad, 
CmdrTaco, liquid nitrogen ice cream, and caffienated jello.  Well why not?
