Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263502AbRFANbb>; Fri, 1 Jun 2001 09:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263504AbRFANbV>; Fri, 1 Jun 2001 09:31:21 -0400
Received: from mail.surgient.com ([63.118.236.3]:29969 "EHLO
	bignorse.SURGIENT.COM") by vger.kernel.org with ESMTP
	id <S263502AbRFANbQ>; Fri, 1 Jun 2001 09:31:16 -0400
Message-ID: <A490B2C9C629944E85CE1F394138AF957FC479@bignorse.SURGIENT.COM>
From: "Collins, Tom" <Tom.Collins@Surgient.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [newbie question] addresses of loaded programs/functions
Date: Fri, 1 Jun 2001 08:30:58 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am writing a profiling tool for a project I am working on,
and I need to know how to map addresses of calling functions
to the appropriate human-readable name.  Is there a data structure
in the kernel that I can access to achieve this?  Or can I reference
a load map (in days gone by, I used to refer to this as a link-edit
map) given the load address of the program?  Where can I find the
load address of the program?

Thanks

Tom Collins
