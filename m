Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVF0VIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVF0VIl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVF0VC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:02:56 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:2939 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261800AbVF0VCl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:02:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q63iV1N6lhS67Vaq+JQheUsBbOQkAG2C0VzlOAtXa2p3Og/vKB/J/rvfJLpdLzVtIUNBoTFxvnaIb4+wYYrqiLi2fbIImRZWGDQvLLY2sHg9JhRC/u3zeGe7xG+2lh/HrRbbM2y3K7pvGMbGD/m9VWbAjlxBT0hnGLyV5Gl2CuM=
Message-ID: <105c793f05062714022ad4359@mail.gmail.com>
Date: Mon, 27 Jun 2005 17:02:37 -0400
From: Andrew Haninger <ahaning@gmail.com>
Reply-To: Andrew Haninger <ahaning@gmail.com>
To: Jim serio <jseriousenet@gmail.com>
Subject: Re: 2.6.X not recognizing second CPU
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3642108305062713487326b672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3642108305062711524e1e163@mail.gmail.com>
	 <105c793f050627123583a70d0@mail.gmail.com>
	 <3642108305062713487326b672@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Jim serio <jseriousenet@gmail.com> wrote:
> Thanks for the reply. I think it was a typo but just in case I did try
> acpi=force and still no go.
I've not used SMP systems much, but AFAIK, power management is not
supported. (Though, I guess ACPI is used for stuff other than power
savings.) Maybe acpi=off?

(I'm stabbing in the dark, now. Watch out.)

-Andy
