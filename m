Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVAWVyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVAWVyR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 16:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVAWVyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 16:54:17 -0500
Received: from ORION.SAS.UPENN.EDU ([128.91.55.26]:10432 "EHLO
	orion.sas.upenn.edu") by vger.kernel.org with ESMTP id S261364AbVAWVyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 16:54:15 -0500
Subject: Re: Trying to fix radeonfb suspending on IBM Thinkpad T41
From: Volker Braun <vbraun@physics.upenn.edu>
To: Antti Andreimann <Antti.Andreimann@mail.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1106450704.10594.52.camel@localhost.localdomain>
References: <1106450704.10594.52.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 16:54:05 -0500
Message-Id: <1106517245.10964.3.camel@carrot.hep.upenn.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update: I compiled a kernel with the radeonfb-massive-update-of-pm-
code.patch. Now I can successfully resume from acpi S3 again. The power
drain issue remains, it still uses about 5W in the suspend state.

-Volker

