Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTLCAs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264460AbTLCAs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 19:48:57 -0500
Received: from pop.gmx.net ([213.165.64.20]:55491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264459AbTLCAsz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 19:48:55 -0500
X-Authenticated: #4512188
Message-ID: <3FCD32F5.2050002@gmx.de>
Date: Wed, 03 Dec 2003 01:48:53 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Craig Bradney <cbradney@zip.com.au>
CC: b@netzentry.com, ross.alexander@uk.neceur.com, s0348365@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org, pomac@vapor.com, forming@charter.net
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
References: <3FCD21E1.5080300@netzentry.com> <1070411338.2452.66.camel@athlonxp.bradney.info>
In-Reply-To: <1070411338.2452.66.camel@athlonxp.bradney.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> smp off, preempt off. lapic on, apic on, acpi on

Why haven't you enabled preempt? Does it lock with preempt on?

Prakash

