Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRLLNXT>; Wed, 12 Dec 2001 08:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280002AbRLLNXA>; Wed, 12 Dec 2001 08:23:00 -0500
Received: from [194.228.240.2] ([194.228.240.2]:50951 "EHLO chudak.century.cz")
	by vger.kernel.org with ESMTP id <S279981AbRLLNWy>;
	Wed, 12 Dec 2001 08:22:54 -0500
Message-ID: <3C175A07.6000505@century.cz>
Date: Wed, 12 Dec 2001 14:22:15 +0100
From: Petr Titera <P.Titera@century.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.6+) Gecko/20011203
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 4GB file size limit on SMBFS
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: OK (checked by AntiVir Version 6.10.0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I tested patches from Urban Wildmark to give SMBFS LFS support and found, 
that limit on file size has only moved from 2GB to 4GB. Is this expected 
behaviour?

Petr Titera
P.Titera@century.cz

