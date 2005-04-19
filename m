Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVDSUIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVDSUIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 16:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVDSUIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 16:08:55 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:25547
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261651AbVDSUIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 16:08:54 -0400
Date: Tue, 19 Apr 2005 13:02:38 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Nico Schottelius <nico-kernel@schottelius.org>
Cc: rlrevell@joe-job.com, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
Message-Id: <20050419130238.2b855462.davem@davemloft.net>
In-Reply-To: <20050419200011.GB16594@schottelius.org>
References: <20050419121530.GB23282@schottelius.org>
	<20050419132417.GS17865@csclub.uwaterloo.ca>
	<1113938220.20178.0.camel@mindpipe>
	<20050419200011.GB16594@schottelius.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005 22:00:12 +0200
Nico Schottelius <nico-kernel@schottelius.org> wrote:

> Can you tell me which ones?

glibc even parses /proc/cpuinfo, so by implication every
application

