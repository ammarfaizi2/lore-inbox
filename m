Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUAURDW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 12:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUAURDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 12:03:22 -0500
Received: from elektra.telenet-ops.be ([195.130.132.49]:63189 "EHLO
	elektra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265988AbUAURDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 12:03:14 -0500
Subject: Re: logging all input and output on a tty
From: Ludootje <ludootje@linux.be>
To: Esben Stien <executiv@online.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87ad4h5juk.fsf@online.no>
References: <87ad4h5juk.fsf@online.no>
Content-Type: text/plain
Message-Id: <1074708271.4724.5.camel@gax.mynet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 21 Jan 2004 18:04:31 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-21 at 16:48, Esben Stien wrote:
> I've been trying to get an answer to tty logging
> for a long time without anyone able to answer.
> I want to log everything that is written to and
> from a certain tty.

You can just cat the device, like cat /dev/tty<number>. So you can also
use normal redirectors (> , >> etc) or use a pager.

Ludootje
-- 
    -----BEGIN GEEK CODE BLOCK-----
    Version: 3.1
    GCS/CC/MU>TW d- s: a--->-->$ C++>$
    UL++++ L+++>++++ M- w--(---) !O V(-)
    P-- E--->+ W++ N+>++ o? PS++(+++)
    PE-() Y+ PGP t- 5? X(+) R- tv+() b+
    DI+(---) D- G e- h! r- y?
    ------END GEEK CODE BLOCK------ 

