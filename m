Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTEPKuz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbTEPKuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 06:50:55 -0400
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:33202 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S264407AbTEPKuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 06:50:54 -0400
Date: Fri, 16 May 2003 12:03:24 +0100
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Cc: michaeltone1975 <michaeltone1975@telstra.com>
Subject: Re: route.c final stable fix committed?
Message-ID: <20030516110324.GA1410@hobbes.itsari.int>
References: <7166a72458.724587166a@bigpond.com> <200305160254.31984.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200305160254.31984.m.c.p@wolk-project.de>; from m.c.p@wolk-project.de on Fri, May 16, 2003 at 01:56:54 +0100
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003.05.16 01:56, Marc-Christian Petersen wrote:
> 
> ? If yes, ...
> > is there an eta or final source archive that has fixes applied?
> Redhat updated their kernel packages, I've updated my tree too, -ac
> hasn't it in yet.
> 

Yes it has. That fix went in on 2.4.21-rc2, so all -rc2 based -ac's 
have it.

The relevant changeset for 2.4 is

http://linux.bkbits.net:8080/linux-2.4/cset@1.1141.2.2?nav=index.html|
ChangeSet@-3w

and also

http://linux.bkbits.net:8080/linux-2.4/cset@1.1141.2.4?nav=index.html|
ChangeSet@-3w


Hope this helps.


Cheers,

			Nuno
