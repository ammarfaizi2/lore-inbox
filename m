Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbUKQWPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbUKQWPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbUKQWM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:12:28 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:17974 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262620AbUKQWMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:12:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MDi6r+YKYf9Tjq/9hfEIOn+t2jiuRykj4qE9G4qrrvRV2L/15z5V6bPLucsm8B71RDG14Au+eN2sK3XcV2O2RBLDR9PFBzONfQuN/Z5KbaBe4HIMJlNzw9ZvOYoZM6QqDw+0qFNpScaDMN1CovJSMKbj+r2LPkO1uWnEBknS60U=
Message-ID: <58cb370e04111714125828fa04@mail.gmail.com>
Date: Wed, 17 Nov 2004 23:12:10 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] ide=nodma printout fix
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aec7e5c3041116065211fe01c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <aec7e5c3041116065211fe01c2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004 15:52:32 +0100, Magnus Damm <magnus.damm@gmail.com> wrote:
> This simple patch changes the output from this:
> ..
> ide_setup: ide=nodmaIDE: Prevented DMA
> ..
> to this:
> ..
> ide_setup: ide=nodma : Prevented DMA
> ..

applied
