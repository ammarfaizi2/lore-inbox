Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSDMGBn>; Sat, 13 Apr 2002 02:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313559AbSDMGBm>; Sat, 13 Apr 2002 02:01:42 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:1197 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S313558AbSDMGBl>; Sat, 13 Apr 2002 02:01:41 -0400
Date: Fri, 12 Apr 2002 23:21:03 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Dolphin PCI-SCI Drivers 2.5.7 Posted (v1.19-2)
Message-ID: <20020412232103.A28928@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The Dolphin PCI-SCI Scalable Coherent Interface Drivers v1.19-2 for 
Linux kernels 2.5.X have been posted to:

ftp://ftp.kernel.org/pub/linux/kernel/people/jmerkey/sci/pci-sci-1.19-2
ftp://ftp.timpanogas.org:/sci/pci-sci-1.19-2
ftp://ftp.utah-nac.org:/sci/pci-sci-1.19-2

Changes/Fixes in this release:

IRM 1.11.4-2 ( April 12, 2002 )
*Linux:  Ported IRM Driver to Linux 2.5.7
*Linux:  Fixed MINOR/minor macro calls to support larger kdev_t values
*Linux:  Fixed i_mmap cleanup in sci_close()
*Linux:  Fixed bus_to_virt/virt_to_phys mappings

SISCI 1.11.4-2 ( April 12, 2002 )
*Linux:  Ported SISCI Library to Linux 2.5.7
*Linux:  Fixed MINOR/minor macro calls to support larger kdev_t values
*Linux:  Fixed i_mmap cleanup in sisci_close()
*Linux:  Fixed remap_page_range remote mapping


Please report bugs/fixed to jmerkey@timpanogas.org or hugo@dolphinics.no.

Jeff V. Merkey

