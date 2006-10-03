Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWJCP3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWJCP3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWJCP3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:29:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:58665 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030215AbWJCP3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:29:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FtVMlrZOdd1HHgkaVxuLxvbacr7O6EVDPNu0R7Y9+VNlIm4MMNbnC7ezhhm1jYFNsjB3K9B7wihJ71EUcEMU3Q44cct4R8lXdRgoGdQnK+5qLnvBCzH+rRmZauv5o6H2y0Bp+zkg23sRlfNoPXDJlhbAd6iMMJ8keO5Z9Iyp2mg=
Message-ID: <126d7b5a0610030829h20e0b63ag8d56c3f9582063cd@mail.gmail.com>
Date: Tue, 3 Oct 2006 17:29:22 +0200
From: "Andrew Martin" <andy.martin.p@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [user question] security.mac.seeotheruids.enabled equivalent in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reading my question :)

I am looking for a Linux equivalent of the
security.mac.seeotheruids.enabled sysctl found on BSD. Preferably one
that works with the latest vanilla mainline kernel.

Basically if it's switched off then users cannot see other users'
processes, network connections, UNIX sockets, mounts, etc... but can
still see if they are logged in or not.

-- 
If thou guardest nae thinge at alle, to Alleman's Ende thou'lt passe and falle.
