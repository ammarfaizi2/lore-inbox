Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422747AbWJLDQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbWJLDQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 23:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422752AbWJLDQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 23:16:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422747AbWJLDQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 23:16:51 -0400
Date: Wed, 11 Oct 2006 20:16:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 0/9] i386-pda: Updated i386 PDA patches against
 2.6.19-rc1-mm1
Message-Id: <20061011201635.da27ff04.akpm@osdl.org>
In-Reply-To: <20061011001021.554882208@goop.org>
References: <20061011001021.554882208@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 17:10:21 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> This is a set of update PDA patches against 2.6.19-rc1-mm1

This now boots and runs OK on that PIII which was previously crashing.
