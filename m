Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTFKVQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTFKVQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:16:16 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:7089 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S264490AbTFKVPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:15:02 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: ak@suse.de, vojtech@suse.cz, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <3EE79FD1.8060503@kolumbus.fi>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <3EE79FD1.8060503@kolumbus.fi>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1055366925.17154.95.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jun 2003 14:28:45 -0700
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 14:32, Mika Penttilä wrote:

> Line below seems to be wrong, given hpet period is in fsecs.

I don't believe the HPET code got much testing in 2.4, and my boxes
don't have ACPI table entries for the HPET, so it's troublesome to test
it on them.

	<b

