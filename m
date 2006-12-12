Return-Path: <linux-kernel-owner+w=401wt.eu-S932411AbWLLTle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWLLTle (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWLLTld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:41:33 -0500
Received: from mms2.broadcom.com ([216.31.210.18]:1755 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932411AbWLLTld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:41:33 -0500
X-Server-Uuid: 05DA3F36-9AA8-4766-A7E5-53B43A7C42E6
Subject: Re: [PATCH 2.6.19] tg3: replace kmalloc+memset with kzalloc
From: "Michael Chan" <mchan@broadcom.com>
To: "Yan Burman" <burman.yan@gmail.com>
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
In-Reply-To: <1165950654.10231.5.camel@localhost>
References: <1165950654.10231.5.camel@localhost>
Date: Tue, 12 Dec 2006 12:30:28 -0800
Message-ID: <1165955428.3505.1.camel@rh4>
MIME-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3)
X-WSS-ID: 6961DA682EK2487854-02-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 21:10 +0200, Yan Burman wrote:
> Replace kmalloc+memset with kzalloc
> 
> Signed-off-by: Yan Burman <burman.yan@gmail.com>

Acked-by: Michael Chan <mchan@broadcom.com>


