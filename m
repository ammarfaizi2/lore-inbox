Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbTJAFu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 01:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbTJAFu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 01:50:59 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:63888 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261959AbTJAFuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 01:50:55 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
References: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
	<E1A4WNJ-000182-00@calista.inka.de>
	<20031001033437.GP7665@parcelfarce.linux.theplanet.co.uk>
	<bldmhg$qoa$1@cesium.transmeta.com> <87r81x5y82.fsf@ceramic.fifi.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 01 Oct 2003 14:50:47 +0900
In-Reply-To: <87r81x5y82.fsf@ceramic.fifi.org>
Message-ID: <buolls5h5fs.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Troin <phil@fifi.org> writes:
> A common uber-ugly trick (seen in Solaris headers) to solve this
> problem is:
> 
>   enum {
>   #define FOO FOO
>     FOO,

I always thought this trick was kind of cool, despite the slight
increase in ugliness for the enum definition.

-Miles
-- 
"Though they may have different meanings, the cries of 'Yeeeee-haw!' and
 'Allahu akbar!' are, in spirit, not actually all that different."
