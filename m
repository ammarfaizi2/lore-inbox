Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbTFCNxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265016AbTFCNxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:53:22 -0400
Received: from holomorphy.com ([66.224.33.161]:27302 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265015AbTFCNxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:53:21 -0400
Date: Tue, 3 Jun 2003 07:05:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Roets, Chris (Tru64&Linux support)" <chris.roets@hp.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/meminfo
Message-ID: <20030603140542.GU8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Roets, Chris (Tru64&Linux support)" <chris.roets@hp.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
References: <224CFA9643B4CE4BA18137CF73DB2F32020E0DBF@broexc01.emea.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224CFA9643B4CE4BA18137CF73DB2F32020E0DBF@broexc01.emea.cpqcorp.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 03:51:47PM +0200, Roets, Chris wrote:
> [Chris >] attached jpeg shows the memory statitiscs of a 6 Gb system
> [Chris >] Does anybody have an idea when my remaining 1.4 Gb can be ?

What JPEG? This is probably either
(a) boot-time code dropping memory regions on the floor
(b) some misunderstanding about reporting in /proc/meminfo

This is also different from your other bugreport.


-- wli
