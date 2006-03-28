Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWC1Pnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWC1Pnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 10:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWC1Pnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 10:43:55 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:8396 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751123AbWC1Pny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 10:43:54 -0500
Date: Tue, 28 Mar 2006 17:44:57 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: cyber rigger <cyber_rigger@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help reporting bug, no 3D accel with Matrox g400
Message-ID: <20060328174457.1e12b6c8@localhost>
In-Reply-To: <20060328151328.53672.qmail@web31811.mail.mud.yahoo.com>
References: <20060328151328.53672.qmail@web31811.mail.mud.yahoo.com>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.12; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 07:13:28 -0800 (PST)
cyber rigger <cyber_rigger@yahoo.com> wrote:

> My test case is ppracer which runs dreadfully slow.

Isn't the output of this command enough to tell if direct rendering is
enabled or not?

glxinfo | grep ^direct

-- 
	Paolo Ornati
	Linux 2.6.16 on x86_64
