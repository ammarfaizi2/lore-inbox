Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRHYLae>; Sat, 25 Aug 2001 07:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbRHYLaZ>; Sat, 25 Aug 2001 07:30:25 -0400
Received: from dfw-smtpout3.email.verio.net ([129.250.36.43]:59804 "EHLO
	dfw-smtpout3.email.verio.net") by vger.kernel.org with ESMTP
	id <S268896AbRHYLaO>; Sat, 25 Aug 2001 07:30:14 -0400
Message-ID: <3B878C56.408216E7@bigfoot.com>
Date: Sat, 25 Aug 2001 04:30:30 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p9ai i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: mount failure, SCSI emulation, 2.2.20pre9
In-Reply-To: <3B85B1E8.99D125C1@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed.  Somehow some idiot (me) set DAO on the Yamaha CRW4416E,
which apparently writes something readable by other CD-R's
except for itself.  Reset to TAO, all is well again.

Apologies to the SCSI emulation code.

t.
--
