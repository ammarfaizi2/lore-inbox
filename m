Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271416AbTGXJUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 05:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271417AbTGXJUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 05:20:22 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:22791 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S271416AbTGXJUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 05:20:07 -0400
To: Dominik Brugger <ml.dominik83@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test1] ACPI slowdown
References: <878yqpptez.fsf@deneb.enyo.de>
	<20030723114421.34eb7149.dominik83@gmx.net>
	<87el0gv3g9.fsf@deneb.enyo.de>
	<20030724112850.0e311b7a.ml.dominik83@gmx.net>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Dominik Brugger <ml.dominik83@gmx.net>,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Jul 2003 11:35:11 +0200
In-Reply-To: <20030724112850.0e311b7a.ml.dominik83@gmx.net> (Dominik
 Brugger's message of "Thu, 24 Jul 2003 11:28:50 +0200")
Message-ID: <87ispsfesw.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brugger <ml.dominik83@gmx.net> writes:

> ==> /proc/acpi/thermal_zone/THRM/temperature <==
> temperature:             37 C

This is at 57 C for me. 8-/

Probably that's why cooling measures kick in.
