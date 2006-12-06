Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936291AbWLFQCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936291AbWLFQCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936301AbWLFQCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:02:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:36385 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936291AbWLFQCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:02:42 -0500
From: Andreas Schwab <schwab@suse.de>
To: Jan Blunck <jblunck@suse.de>
Cc: Phil Endecott <phil_arcwk_endecott@chezphil.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
References: <4de7f8a60612060704k7d7c1ea3o1d43bee6c5e372d4@mail.gmail.com>
	<1165418558832@dmwebmail.belize.chezphil.org>
	<20061206155439.GA6727@hasse.suse.de>
X-Yow: There's enough money here to buy 5000 cans of Noodle-Roni!
Date: Wed, 06 Dec 2006 17:02:40 +0100
In-Reply-To: <20061206155439.GA6727@hasse.suse.de> (Jan Blunck's message of
	"Wed, 6 Dec 2006 16:54:39 +0100")
Message-ID: <jewt55c8rj.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Blunck <jblunck@suse.de> writes:

> Maybe the arm backend is somehow broken.

A packed structure is something quite different than a structure of packed
members.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
