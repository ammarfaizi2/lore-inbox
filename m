Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWDUPRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWDUPRQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWDUPRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:17:16 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:11690 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S932349AbWDUPRP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:17:15 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Device-mapper snapshot metadata userspace breakage
References: <Pine.LNX.4.58.0604201159350.29821@sbz-30.cs.Helsinki.FI>
	<20060420173717.GI24520@agk.surrey.redhat.com>
	<Pine.LNX.4.58.0604210938390.29821@sbz-30.cs.Helsinki.FI>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Pekka J Enberg <penberg@cs.Helsinki.FI>,
	linux-kernel@vger.kernel.org
Date: Fri, 21 Apr 2006 17:17:09 +0200
In-Reply-To: <Pine.LNX.4.58.0604210938390.29821@sbz-30.cs.Helsinki.FI> (Pekka
	J. Enberg's message of "Fri, 21 Apr 2006 09:41:15 +0300 (EEST)")
Message-ID: <87vet39cwa.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J. Enberg <penberg@cs.Helsinki.FI> writes:

> On Thu, 20 Apr 2006, Alasdair G Kergon wrote:
>>> lvm2  2.01.04-5
>>> device-mapper 1.01.00-4
>>
>> Upgrade!
>
> Not in Debian stable, so I guess we'll need to downgrade. That's too
> bad for all of us because now we have one less tester for new
> kernels. Oh well..

As said, I've made packages of device-mapper 1.02.03 and and
lvm2 2.02.02 for Debian stable:

deb http://blog.blackdown.de/static/debian/lvm/ sarge main


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
