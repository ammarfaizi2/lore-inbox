Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWEVRuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWEVRuc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWEVRub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:50:31 -0400
Received: from agrajag.inprovide.com ([82.153.166.94]:3762 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S1751095AbWEVRub convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:50:31 -0400
To: John Levon <levon@movementarian.org>
Cc: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, phil.el@wanadoo.fr,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Is OPROFILE actively maintained?
References: <20060520025322.GD9486@taniwha.stupidest.org>
	<20060521194915.GA2153@taniwha.stupidest.org>
	<1148298681.17376.23.camel@localhost.localdomain>
	<20060522151528.GA20960@totally.trollied.org>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Mon, 22 May 2006 18:50:28 +0100
In-Reply-To: <20060522151528.GA20960@totally.trollied.org> (John Levon's message of "Mon, 22 May 2006 16:15:28 +0100")
Message-ID: <yw1xwtce0x0b.fsf@agrajag.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (Security Through Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Levon <levon@movementarian.org> writes:

> On Mon, May 22, 2006 at 12:51:21PM +0100, Alan Cox wrote:
>
>> Be serious, oprofile is good working code, even if you have some
>> personal problem with it.
>
> Does the opinion of the former mantainer count for nothing? If nothing
> else, it should remain experimental on arches like Alpha, where there's
> a whole bunch of events that can't possibly work.

Why should be marked experimental only because of architecture limits?
If the parts that can work, work well, there's no reason to suggest
otherwise.  (Speaking as an Alpha owner)

-- 
Måns Rullgård
mru@inprovide.com
