Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292343AbSBULfK>; Thu, 21 Feb 2002 06:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292345AbSBULfB>; Thu, 21 Feb 2002 06:35:01 -0500
Received: from portal.west.saic.com ([198.151.12.15]:13018 "HELO
	portal.west.saic.com") by vger.kernel.org with SMTP
	id <S292342AbSBULen>; Thu, 21 Feb 2002 06:34:43 -0500
Subject: Re: 2.4.17: fails to detect PCI bus
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1014289078.15561.26.camel@ukabzc383.uk.saic.com>
In-Reply-To: <1014289078.15561.26.camel@ukabzc383.uk.saic.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 21 Feb 2002 11:33:29 +0000
Message-Id: <1014291210.15562.35.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small update, it looks like it's the direct access method that's broken,
pci=bios seems to work fine.

This is probably bad :-)

Cheers,
Eamonn


