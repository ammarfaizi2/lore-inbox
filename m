Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755441AbWKNHB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755441AbWKNHB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbWKNHB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:01:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59570 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755441AbWKNHB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:01:56 -0500
Subject: Re: [2.6 patch] make arch/i386/kernel/io_apic.c:irq_vector[] static
From: Ingo Molnar <mingo@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061113210342.GE22565@stusta.de>
References: <20061113210342.GE22565@stusta.de>
Content-Type: text/plain
Date: Tue, 14 Nov 2006 07:59:59 +0100
Message-Id: <1163487599.28401.55.camel@earth>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 22:03 +0100, Adrian Bunk wrote:
> irq_vector[] can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Ingo Molnar <mingo@redhat.com>

	Ingo

