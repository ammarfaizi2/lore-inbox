Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293152AbSBZVsJ>; Tue, 26 Feb 2002 16:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293070AbSBZVrx>; Tue, 26 Feb 2002 16:47:53 -0500
Received: from zero.tech9.net ([209.61.188.187]:21517 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292835AbSBZVrl>;
	Tue, 26 Feb 2002 16:47:41 -0500
Subject: Re: crypto (was Re: Congrats Marcelo,)
From: Robert Love <rml@tech9.net>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202262140.g1QLet111256@fenrus.demon.nl>
In-Reply-To: <200202262140.g1QLet111256@fenrus.demon.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 26 Feb 2002 16:47:44 -0500
Message-Id: <1014760064.1107.39.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-02-26 at 16:40, arjan@fenrus.demon.nl wrote:

> loopback mount crypto. you want the actual crypts in kernel to avoid 2
> context switches per block you read.

Oh, yes, indeed -- encrypted filesystems.  Then the issue is resolving
the various international concerns.

	Robert Love

