Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVFNWqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFNWqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVFNWqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:46:43 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:45224 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261393AbVFNWqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:46:39 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: =?ISO-8859-1?Q?J=F6rg?= Schilling again... [Please reply CC: wdraxinger@darkstargames.de]
To: Wolfgang Draxinger <wdraxinger@darkstargames.de>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 15 Jun 2005 00:46:21 +0200
References: <4fgGA-7S1-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DiKAo-0003LH-Mu@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Draxinger <wdraxinger@darkstargames.de> wrote:

> Well I didn't cared about the so called issues, as I never had
> problems with cdrecord - ok the SUID bug required me to workaround,
> but nothing that a 5 line sh script and a "%cdrw  ALL=(ALL)
> NOPASSWD: /usr/bin/cdrecord.real" rule for sudo can't solve.

The new alpha version of cdrtools has the workaround.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
