Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTLLSIq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 13:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTLLSIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 13:08:46 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:52121
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S261605AbTLLSIq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 13:08:46 -0500
Date: Fri, 12 Dec 2003 13:17:04 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6 and IDE "geometry"
Message-ID: <20031212131704.A26577@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there anyway to get kernel 2.6 to use the geometry the bios has for an
IDE drive?

I have a installation setup that installs a non-linux os and I partition the
drive under linux.  In 2.4 this has worked flawlessly, however, 2.6 reports
as # cylinders/16 heads/63 sectors.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
