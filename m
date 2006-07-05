Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWGEA2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWGEA2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 20:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWGEA2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 20:28:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:19012 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932364AbWGEA2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 20:28:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Pcvlb2BBsq1SNHhsZZWUEp9NeaqANwUVrrDkpI4Ptlc2SoQS0ZyV3BaLEXAVhBafnr6+u73Ez6l1WYXSCc5CMbQcWkHWlCdI3DbZ0+S7bmkRfHMivVHVKvful+EWkJfIQ2wvIwPLP2kztyrH9zoUPJuWbSJprhjdq2b7+cgH064=
Message-ID: <a36005b50607041728h1442ebaapdd9d13b5d13fd3c4@mail.gmail.com>
Date: Tue, 4 Jul 2006 17:28:30 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Esben Nielsen" <nielsen.esben@googlemail.com>
Subject: Re: Where can I get glibc with PI futex support (for -RT tests) ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607050133240.2448@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0607050133240.2448@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/06, Esben Nielsen <nielsen.esben@googlemail.com> wrote:
> The answer is probably on the list, but I can't find it in the
> archives..:-(

You have to wait your turn like everybody else.  Ingo/Thomas have one
more bug to fix.  After that I'll check in the patches into the cvs
archive.
