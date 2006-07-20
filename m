Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWGTGwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWGTGwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 02:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWGTGwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 02:52:20 -0400
Received: from mail.phnxsoft.com ([195.227.45.4]:26383 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1030275AbWGTGwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 02:52:19 -0400
Date: Thu, 20 Jul 2006 08:52:07 +0200
Message-Id: <200607200652.k6K6q771011722@posthamster.phnxsoft.com>
From: Tilman Schmidt <tilman@imap.cc>
Subject: Re: "Why Reuser 4 still is not in" doc
To: Diego Calleja <diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, Lexington.Luthor@gmail.com,
       linux-kernel@vger.kernel.org
References: <20060716161631.GA29437@httrack.com>
	<20060716162831.GB22562@zeus.uziel.local>
	<20060716165648.GB6643@thunk.org>
	<e9dsrg$jr1$1@sea.gmane.org>
	<20060716174804.GA23114@thunk.org>
	<20060716220115.a1891231.diegocg@gmail.com>
X-Spam-Score: 3.561 (***) AWL,BAYES_95
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jul 2006 22:01:15 +0200, Diego Calleja wrote:
> Maybe it's too late and reiser 4 will get in in the next release, but
> I've written this doc into the kernelnewbies' wiki:
> http://wiki.kernelnewbies.org/WhyReiser4IsNotIn . If you disagree with
> something in that doc, edit it or just answer to this mail what you want
> to see in it and I'll add it myself.

It could be improved in two ways in order to better convince people:

Firstly, mention some (perhaps even all) of the actual technical
issues preventing the inclusion of Reiser4. Right now, you are
giving much space to the political issues (or their non-existence).
This answers a different question ("Why we are fed up with the
Reiser4 discussion") than the one in the title, and in the worst
case might leave a reader with the impression that political
reasons are more important after all.

Secondly, the questions in the FAQ part should probably be put in a
less loaded form. For example, Q1 could just read objectively:
"Why can't Reiser4 be included as an experimental feature?"
As it stands now, I fear too many people's reaction upon reading it
will be: "That's not my question." At least leave off the plaintive
initial "but" on Q1 and Q2. It puts off the readers you want to
convince.

HTH
Tilman

