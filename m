Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292975AbSCFBhI>; Tue, 5 Mar 2002 20:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292983AbSCFBg7>; Tue, 5 Mar 2002 20:36:59 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:24744 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S292975AbSCFBgo>;
	Tue, 5 Mar 2002 20:36:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: arjan@fenrus.demon.nl, Brian S Queen <bqueen@nas.nasa.gov>
Subject: Re: dnotify for kernel 2.2
Date: Tue, 5 Mar 2002 17:36:24 -0800
X-Mailer: KMail [version 1.3.99]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203051857.g25Ivl627158@fenrus.demon.nl>
In-Reply-To: <200203051857.g25Ivl627158@fenrus.demon.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200203051736.24446.bodnar42@phalynx.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 5, 2002 10:57, arjan@fenrus.demon.nl wrote:
> Does the 2.4 version actually work ?

If you have KDE installed:

1) Open a file manager window
2) From a console, 'touch foo'
3) Watch 'foo' appear in the file manager window
4) From a console, 'rm foo'
5) Watch 'foo' disppear again

Unless you have FAM running, that's dnotify at work.

-Ryan
