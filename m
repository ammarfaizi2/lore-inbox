Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268540AbTANCuF>; Mon, 13 Jan 2003 21:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268543AbTANCtv>; Mon, 13 Jan 2003 21:49:51 -0500
Received: from pD9E10F96.dip.t-dialin.net ([217.225.15.150]:3968 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S268540AbTANCsY>;
	Mon, 13 Jan 2003 21:48:24 -0500
Date: Tue, 14 Jan 2003 03:52:46 +0100
From: Felix von Leitner <felix-linuxkernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: "PCI BIOS passed nonexistant PCI bus 0"
Message-ID: <20030114025245.GA1175@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also get

  PCI BIOS passed nonexistant PCI bus 1

How can this be?  I configured the kernel with:

  # CONFIG_PCI_GOBIOS is not set
  CONFIG_PCI_GODIRECT=y

What is this option good for if Linux still listens to what the BIOS says?

Felix
