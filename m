Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTJHN2u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 09:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTJHN2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 09:28:49 -0400
Received: from mail.convergence.de ([212.84.236.4]:5345 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261463AbTJHN2t convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 09:28:49 -0400
Subject: [PATCH 1/14] LinuxTV.org DVB driver update
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 8 Oct 2003 15:28:47 +0200
Message-Id: <10656197274033@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the periodical patchset bomb to keep the DVB subsystem and the
various DVB drivers from the LinuxTV.org CVS in sync with 2.6.

There are 13 individual patches, all have detailed patch desriptions in
the top of the file. There is some fuzziness, mainly due to the "video-buf"
updates from Gerd Knorr yesterday.

Please apply.

Thanks
Michael.

