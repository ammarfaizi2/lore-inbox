Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTJRURu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 16:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTJRURu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 16:17:50 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:56495 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261825AbTJRURt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 16:17:49 -0400
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
	<200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
	<33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
	<20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net>
	<3F8BBC08.6030901@namesys.com>
	<11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
	<20031017102436.GB10185@bitwizard.nl>
	<200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
	<m3zng0yun9.fsf@defiant.pm.waw.pl>
	<200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk>
	<m37k33igui.fsf@defiant.pm.waw.pl>
	<200310180827.h9I8Rxw8000383@81-2-122-30.bradfords.org.uk>
	<m3u166vjn0.fsf@defiant.pm.waw.pl> <3F9169A2.1050506@vgertech.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Oct 2003 22:16:16 +0200
In-Reply-To: <3F9169A2.1050506@vgertech.com>
Message-ID: <m3d6cuuwrz.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuno Silva <nuno.silva@vgertech.com> writes:

> > Doing cat /dev/zero > /dev/hd* fixes all bad sectors on modern drive.
> 
> Yeah! I'm doing this right now because the data in hda is very
> important and and don't do backups since August!! :-D

Aaah right... August - which year exactly? :-)

(Just in case someone wants to try this on live disk - it erases all data
in the process).
-- 
Krzysztof Halasa, B*FH
