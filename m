Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWGLSgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWGLSgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWGLSgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:36:04 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:27841 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932328AbWGLSgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:36:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i3G5p00Ibpt1+8szxGAbPG8Gy0nOgjOPkoc6InLxMMeqKDamKrkY+qSE2QxECN4T3/Vh5NAaIbnfFwYcwFaq5w08jIZ5vodCf6+yLHjrmAowtfpgTU5xPKhisL+QKDGXhkGOVuFP/TVV8yDschaEQR7iJJgYIPWhns7+g1gHsRc=
Message-ID: <f36b08ee0607121136m1cb31a9ehf735ef67aac3fc1a@mail.gmail.com>
Date: Wed, 12 Jul 2006 21:36:00 +0300
From: "Yakov Lerner" <iler.ml@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com
Subject: tool for measuring interactive responsiveness of the system under load ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to run a benchmark, a tool that measures responsiveness of
[simulated]  interactive  program on a loaded system.
My question is, which program (benchmark) exists for measuring
the responsiveness [of the kernel under certain load]  to interactive
usage ?

Yakov

P.S. I remember ,vaguely, reading that Ingo Molnar used some tool
when tuning scheduler several years ago, but I don't know what's name
of the tool/benchmark and where it exists.
