Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbRBMW4l>; Tue, 13 Feb 2001 17:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129772AbRBMW4b>; Tue, 13 Feb 2001 17:56:31 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:55710 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129496AbRBMWzz>; Tue, 13 Feb 2001 17:55:55 -0500
Message-ID: <3A89BA64.D85CCB6B@didntduck.org>
Date: Tue, 13 Feb 2001 17:51:16 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrey Panin <pazke@orbita.don.sitek.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IRQ conflicts
In-Reply-To: <E14RfhV-0002A1-00@the-village.bc.nu> <3A85D79C.3DE3A527@didntduck.org> <20010213124400.A1860@debian> <20010213125212.A2135@debian>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Panin wrote:
> 
> Hi Brian.
> 
> I'm sorry, patch itself was not attached in previous post :(
> 

Yes, this does fix that part of the problem.  There is still the matter
of the class code being wrong but I have ideas on how to fix that.

-- 

						Brian Gerst
