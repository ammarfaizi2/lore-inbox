Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWCRIfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWCRIfe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 03:35:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWCRIfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 03:35:34 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:58057
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932265AbWCRIfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 03:35:34 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: linux-kernel@vger.kernel.org
Subject: Dual Core on Linux questions
Date: Sat, 18 Mar 2006 02:35:33 -0600
Message-Id: <20060318082434.M33432@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 200.91.94.134 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a few questions about the PM Dual Core and how could it really work
with Linux. Sorry if there are new patches on LKML about any of these things:

Could each processor or die, have it's own cpufreq scaling governor?

Is there a way to allow one die to be idle and let the other one normal?

So in other words, could we manage these processors speedstep, utilization and
workload individually?

Thanks!

.Alejandro
