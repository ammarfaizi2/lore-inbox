Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUKXXJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUKXXJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUKXXGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:06:06 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:60801 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262900AbUKXXCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:02:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lAm505luaA8FxIq7qNL7wNFq74+uoO2qo4VQF1Q46hjO63bvkRisLPk9MgRfTo44TjBN0Dzn7JO0V8XXMWXT1mE1FLnK77tujOOp7fCzhdMu3DS7vDi1btAvREBrblcmeZazpjCxKzg2hjKbc1rM+Otwu7y7smtpO/GO295flwA=
Message-ID: <58cb370e04112415014eaaebaf@mail.gmail.com>
Date: Thu, 25 Nov 2004 00:01:21 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: ncunningham@linuxmail.org
Subject: Re: Suspend 2 merge: 46/51: LZF support.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101300108.5805.380.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <1101300108.5805.380.camel@desktop.cunninghams>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nigel!

Shouldn't LZF code go to lib/ ?

On Thu, 25 Nov 2004 00:02:09 +1100, Nigel Cunningham
<ncunningham@linuxmail.org> wrote:
> This is LZF support, contributed under a dual license (see below) by
> Marc Lehmann. It flies! (Those stats in the debug info in an earlier
> patch were real!).
