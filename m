Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754597AbWKMR2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754597AbWKMR2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbWKMR2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:28:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:40927 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1754597AbWKMR2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:28:51 -0500
From: Andi Kleen <ak@suse.de>
To: vgoyal@in.ibm.com
Subject: Re: [RFC] [PATCH 9/16] x86_64: 64bit PIC SMP trampoline
Date: Mon, 13 Nov 2006 18:28:46 +0100
User-Agent: KMail/1.9.5
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
References: <20061113162135.GA17429@in.ibm.com> <20061113164201.GJ17429@in.ibm.com>
In-Reply-To: <20061113164201.GJ17429@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131828.46963.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +verify_cpu:

Another duplication. Please get rid of that.

-Andi
