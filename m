Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUCESWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbUCESWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:22:24 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:61110 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262670AbUCESWB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:22:01 -0500
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: server migration 
Date: Fri, 5 Mar 2004 18:21:59 +0000 (UTC)
Organization: Cistron
Message-ID: <c2agg7$9hf$1@news.cistron.nl>
References: <20040305181322.GA32114@the-penguin.otak.com>
X-Trace: ncc1701.cistron.net 1078510919 9775 62.216.30.38 (5 Mar 2004 18:21:59 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lawrence Walton  <lawrence@the-penguin.otak.com> wrote:
>I'd like to take another shot at it with 2.6.3,

Don't!

<personal experience, ymmv!>
Problems after sync, difficulties in the blocklayer/queuing/plugging.
Our newsgateway has gone back to 2.6.0-test11 since that's the
only one that seems to survive "hard-work".

2.6.4-rc1(-mm1) crashed hard on me, doing single-user stuff.
_i_ would wait a while if i were in your position.

Danny
-- 
 /"\                        | Dying is to be avoided because
 \ /  ASCII RIBBON CAMPAIGN | it can ruin your whole career 
  X   against HTML MAIL     | 
 / \  and POSTINGS          | - Bob Hope

