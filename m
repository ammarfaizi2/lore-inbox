Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262160AbSJAScG>; Tue, 1 Oct 2002 14:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262170AbSJAScG>; Tue, 1 Oct 2002 14:32:06 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:20471 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262160AbSJAScF> convert rfc822-to-8bit; Tue, 1 Oct 2002 14:32:05 -0400
Content-Class: urn:content-classes:message
Subject: RE: Stupid luser question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Date: Tue, 1 Oct 2002 19:36:49 +0100
Message-ID: <541025071C7AC24C84E9F82296BB9B950806ED@OPTEX1.optex.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stupid luser question
Thread-Index: AcJpdfYOe4vy9WJGRvGM7gWlkzjH/wAAzyQw
From: "John Hall" <john.hall@optionexist.co.uk>
To: <linux-kernel@vger.kernel.org>
Cc: <jbradford@dial.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 October 2002 19:14 jbradford@dial.pipex.com
<jbradford@dial.pipex.com> wrote:

> Just wondering, what is the purpose of the comment /* { */ which is
> found in various seemingly random places in the kernel:
> 
> # grep -F -r "/* { */" *

I would guess that they were put there by someone who uses a folding
editor. If you look for matching #endif's you will find a /* } */.

regards,
john
