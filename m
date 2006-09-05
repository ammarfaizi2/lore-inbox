Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWIEKGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWIEKGh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWIEKGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:06:37 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:40679 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751158AbWIEKGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:06:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nLl2q3XAC7FvCf0rG68G/j5/8t9BD89pAXq/RWsG/8t18DOsQ1nHjKgxga+caH28X++vFyx3GSw9faCcFYYaPy8bD8m3ZCkcimacwRlBoew5NBV6RlQIaZahY6wcz0ats2vNTDuODU8P3OFerLxv/mKFPbyDzzWLcqORsFWIFSQ=
Message-ID: <3634de740609050306y38ff56a4t2700e044e11a439f@mail.gmail.com>
Date: Tue, 5 Sep 2006 15:36:27 +0530
From: Maximus <john.maximus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SDIO functions?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    Just going through the sdio specs and ossman's patch.


   What are these functions and thier numbers in CMD 53

   Does that mean an SDIO Card can support upto 8 different functions?.

   An sdio card can be used as a wlan and camera (if it supports 2
functions wlan and camera).

  Is it like that?. Because i have not come across a card which
supports more than one function.

  What does "function" mean - does that mean some kind of firmware
inside the card or some kind electronics.

  I dont understand.


Thanks and Regards,
Jo
