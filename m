Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTFMWyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 18:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265569AbTFMWyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 18:54:46 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17336
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264005AbTFMWyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 18:54:45 -0400
Subject: Re: Modular IDE Build Failing Without Modular Generic PCI
	bus-master DMA support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fred Feirtag <ffeirtag@integrityns.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EEA4E52.4080205@integrityns.com>
References: <3EEA4E52.4080205@integrityns.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055545575.6592.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 00:06:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-06-13 at 23:21, Fred Feirtag wrote:
> Under 2.4.20, "Generic PCI bus-master DMA support"
> could be built into the kernel (modular was never an option),
> and IDE could link modular, as for use in an OS-less
> NFS/Samba file server.  Is modular IDE with DMA still broken,
> since Generic PCI bus-master DMA support can't be a module?

I'm working on it but yes

