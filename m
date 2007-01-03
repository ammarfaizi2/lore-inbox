Return-Path: <linux-kernel-owner+w=401wt.eu-S932111AbXACVA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbXACVA2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbXACVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:00:28 -0500
Received: from smtp.telefonica.net ([213.4.149.66]:55398 "EHLO
	ctsmtpout1.frontal.correo" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932111AbXACVA1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:00:27 -0500
From: Jose Alberto Reguero <jareguero@telefonica.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ahci and Marvell 88SE6121
Date: Wed, 3 Jan 2007 22:00:25 +0100
User-Agent: KMail/1.9.5
References: <200701032035.06176.jareguero@telefonica.net>
In-Reply-To: <200701032035.06176.jareguero@telefonica.net>
Cc: Jose Alberto Reguero <jareguero@telefonica.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701032200.26021.jareguero@telefonica.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Miércoles, 3 de Enero de 2007 20:35, escribió:
> I am trying to make work the driver ahci with Marvell 88SE6121 but not
> succes. The log is good?

This line:
ahci 0000:06:00.0: AHCI 0001.0000 32 slots 3 ports 3 Gbps 0x7 impl IDE mode
Looks good for me except " IDE mode". I think must be "SATA mode"

Thanks.
Jose Alberto
