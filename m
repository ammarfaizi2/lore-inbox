Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030352AbWAXPNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030352AbWAXPNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbWAXPNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:13:33 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:4009 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030352AbWAXPNc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:13:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pYOsFtcsnQbMhoEyVl2r74oQO5OMY3iD7U2r3fuSmw7q87b2jrPjlohHWGKFIekgku76BLMW1PJdK2JnttJHdjzJV8UnT+qzNfC+AuJjiXf+pG2emX/HbE0QUOvxGZPGNT6yjb/Xv71suvaKfI9VtNvvgGhGvvYZxa6q/6J0E5Y=
Message-ID: <40f323d00601240713x26c3a04cra46e1cd9639b12f2@mail.gmail.com>
Date: Tue, 24 Jan 2006 16:13:30 +0100
From: Benoit Boissinot <bboissin@gmail.com>
To: Andy Spiegl <kernelbug.Andy@spiegl.de>, John Stoffel <john@stoffel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.15 crashes X Server after running OpenGL programs
In-Reply-To: <20060124142151.GA3538@spiegl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060124121542.GB13646@spiegl.de>
	 <17366.13811.386903.438419@smtp.charter.net>
	 <20060124142151.GA3538@spiegl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/06, Andy Spiegl <kernelbug.Andy@spiegl.de> wrote:
> Too bad there is no free OpenGL driver - I hate to use closed source stuff.

Radeon 9000 is supported in Xorg and as far as i know was already supported
in Xfree86. The open-source driver works fine for me (Radeon 9200SE).

regards,

Benoit
