Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130986AbQKNMlz>; Tue, 14 Nov 2000 07:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbQKNMlq>; Tue, 14 Nov 2000 07:41:46 -0500
Received: from mx3.port.ru ([194.67.23.37]:57614 "EHLO mx3.port.ru")
	by vger.kernel.org with ESMTP id <S130986AbQKNMle>;
	Tue, 14 Nov 2000 07:41:34 -0500
From: "Samium Gromoff" <_deepfire@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: /proc tweaking
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.34.30.70]
Reply-To: "Samium Gromoff" <_deepfire@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E13vevy-0003Lv-00@f4.mail.ru>
Date: Tue, 14 Nov 2000 15:11:31 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Hey people, i`ve got such a thought
    not long ago:
      all boxes are different, but the /proc/sys/vm
      defaults are equal for every people, so there
      is a good issue in getting more performance
      from linux, just by making a way to autoadjust
      these mysterious values according to amount of
      RAM/swap and speed of CPU!  Or this can be done 
      in userspace with an utility which look also 
      on the field of box` use (eg workstation, server        etc...)
          But who can make this better than the people        who hack the kernel?
          And i wonder why such a issue is not clearly        covered? (maybe i`m making mistake?)
          This can also be done for proc/sys/net/*...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
