Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129842AbRAXPKQ>; Wed, 24 Jan 2001 10:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131128AbRAXPKH>; Wed, 24 Jan 2001 10:10:07 -0500
Received: from iq.sch.bme.hu ([152.66.226.168]:19756 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S129842AbRAXPJ4>;
	Wed, 24 Jan 2001 10:09:56 -0500
Date: Wed, 24 Jan 2001 16:12:49 +0100
Message-Id: <200101241512.QAA01140@iq.rulez.org>
From: "Sasi Peter" <sape@iq.rulez.org>
To: James Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
X-Mailer: NeoMail 1.21
X-IPAddress: 195.228.20.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> AIUI, Jeff Merkey was working on loading "userspace" apps into the 
kernel
> to tackle this sort of problem generically. I don't know if he's 
tried it
> with Samba - the forking would probably be a problem...

I think, that is not what we need. Once Ingo wrote, that since HTTP 
serving can also be viewed as a kind of fileserving, it should be 
possible to create a TUX like module for the same framwork, that serves 
using the SMB protocol instead of HTTP...

-- SaPE / Sasi Péter / mailto: sape@sch.hu / http://sape.iq.rulez.org/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
