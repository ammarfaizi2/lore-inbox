Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWHKOgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWHKOgo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 10:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWHKOgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 10:36:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:28339 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751150AbWHKOgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 10:36:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W/wV6mYtd8IUNO6fHCccoebmMKL3QCnKqICXsoK8jNMCGiH7qSiedVkzbiKtYe1caRreYs76auVq7J9k+WaSzBcENnYq9JvDSS5wQg0RK2tdaan6x/dYOnvbBCFYHL+5pAXTtgzh2+c1/RGqVZZdUuBLFzUcHZxgh0WZ8hTVDx4=
Message-ID: <15ce3ec0608110736y5ef185e8v6acd4f7556adcc49@mail.gmail.com>
Date: Fri, 11 Aug 2006 10:36:38 -0400
From: "Steve Barnhart" <stb52988@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: bootsplash integration
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am looking for an update on the reasons (or objections) to
bootsplash (bootsplash.org) still not being integrated into the
kernel. I believe its a very nice project, especially w/regard to
looks for Linux and think it would be a good addition and save a lot
of time for many people who have to go through patching their kernel
if they want it.

There's also gensplash
(http://dev.gentoo.org/~spock/projects/gensplash/) which is a little
different and requires only an fbsplash patch to the kernel and only
if you want a background picture on the consoles after bootup (a nice
feature imo).

Both of these are nice packages that I would love to have officially
included and was jus wondering what everyone's current objections to
it are.

-- 
Steve
