Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264635AbRGBWfW>; Mon, 2 Jul 2001 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbRGBWfN>; Mon, 2 Jul 2001 18:35:13 -0400
Received: from adsl-63-198-73-118.dsl.lsan03.pacbell.net ([63.198.73.118]:2569
	"HELO turing.xman.org") by vger.kernel.org with SMTP
	id <S265459AbRGBWfC>; Mon, 2 Jul 2001 18:35:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christopher Smith <x@xman.org>
To: Dan Kegel <dank@kegel.com>, "Daniel R.Kegel" <dank@alumni.caltech.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: A signal fairy tale
Date: Mon, 2 Jul 2001 15:33:08 -0700
X-Mailer: KMail [version 1.2.3]
In-Reply-To: <3B3CCCFF.2329FEDD@kegel.com>
In-Reply-To: <3B3CCCFF.2329FEDD@kegel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010702223501.BFAB856F7@turing.xman.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to confirm Dan. I was a fool and did not install the dummy handler for 
the masked signal I was using. I added the proper code over the weekend with 
no noticable effect (JDK 1.3 still sigtimedwait()'s on the signal :-().

--Chris
