Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbTJDT1n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTJDT1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 15:27:42 -0400
Received: from havoc.gtf.org ([63.247.75.124]:61335 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262716AbTJDT1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 15:27:36 -0400
Date: Sat, 4 Oct 2003 15:27:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Erik Andersen <andersen@codepoet.org>,
       Philippe Lochon <plochon.n0spam@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: P4C800E-Dlx: ICH5/S-ATA and Intel Pro onboard network incompatibility ?
Message-ID: <20031004192733.GA30371@gtf.org>
References: <3F7EDCDD.7090500@free.fr> <20031004180338.GA24607@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031004180338.GA24607@codepoet.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh yeah, when ICH5 SATA is configured to native mode, "lspci -vvvxxx"
output -- when run as root -- would be helpful as well.

	Jeff




