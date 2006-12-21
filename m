Return-Path: <linux-kernel-owner+w=401wt.eu-S1423067AbWLUUdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423067AbWLUUdj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423076AbWLUUdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:33:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46463 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423067AbWLUUdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:33:38 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Tomas Carnecky <tom@dbservice.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Scott Preece <sepreece@gmail.com>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       James Porter <jameslporter@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Binary Drivers
References: <loom.20061215T220806-362@post.gmane.org>
	<20061215220117.GA24819@martell.zuzino.mipt.ru>
	<4583527D.4000903@dbservice.com>
	<m13b7ds25w.fsf@ebiederm.dsl.xmission.com>
	<7b69d1470612210833k79c93617nba96dbc717113723@mail.gmail.com>
	<20061221174346.GN3073@harddisk-recovery.com>
	<458ADC37.9070608@dbservice.com>
Date: Thu, 21 Dec 2006 13:32:37 -0700
In-Reply-To: <458ADC37.9070608@dbservice.com> (Tomas Carnecky's message of
	"Thu, 21 Dec 2006 19:10:47 +0000")
Message-ID: <m1ac1hng62.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Carnecky <tom@dbservice.com> writes:

> The problem is, nobody wants to decide what to do with closed source software in
> Linux. I don't care how you decide, for or against binary drivers (well,
> actually I do but my opinion doesn't matter), just decide already!

The decision from Linus was simple.  Linus will not merge a patch that
attempts to prevent this from at a technical level.  No one has made
any exceptions to the GPL to say that GPL incompatible drivers are
allowed.  Therefore on a legal level kernel drivers with GPL
incompatible drivers are as illegal as the derivative works clause in
copyright law will allow us to make them.  If you want something
firmer you can go talk to your appropriate government about taking the
fuzz out of what is a derivative work. 

As a practical matter people not releasing source aren't playing well with us 
so we are not likely to play well with them.

Eric
