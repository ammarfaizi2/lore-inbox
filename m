Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933563AbWKQMsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbWKQMsF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 07:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933574AbWKQMsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 07:48:05 -0500
Received: from smtp-out-46.synserver.de ([217.119.50.46]:45530 "HELO
	smtp-out-46.synserver.de") by vger.kernel.org with SMTP
	id S933563AbWKQMsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 07:48:01 -0500
X-SynServer-RBL-Internally-Whitelisted: 1
X-SynServer-ViaOpenRelay-IP: 84.161.132.201
X-SynServer-RBL-IP: 84.161.132.201
X-SynServer-RBL-ReportedBy: dynablock.njabl.org
X-SynServer-RBL-ReportedByCount: *
X-SynServer-RBL-Weights: 100
X-SynServer-RBL-WeightSum: 100
X-SynServer-RBL-WeightStr: **********
X-SPAM-FLAG: Yes
X-SynServer-AuthUser: chris@schlagmichtod.de
X-SynServer-RemoteDnsName: p54A184C9.dip0.t-ipconnect.de
Message-ID: <455DAF74.1050203@schlagmichtod.de>
Date: Fri, 17 Nov 2006 13:47:48 +0100
From: Christoph Schmid <chris@schlagmichtod.de>
User-Agent: IceDove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: is there any Hard-disk shock-protection for 2.6.18 and above?
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello dear kernel-people,

I have a little question, which i hope is right to post here and does
not cause inconveniences.

Well, since about 6 weeks i own a Lenovo Thinkpad X60s which i bought
primarily because thinkpads are rumored to be very well supported by
linux. Sencondly because as a student i got some rebate on thinkpads ;)

Well, the actual question is the following,
I read about HDAPS on thinkWiki. But there is no known-to-work patch for
2.6.18 and above to enable queue-freezing/harddisk parking.
After some googeling and digging in gamne i read that someone said that
there are plans for some generic support for HD-parking in the kernel
and thus making such patches obsolete.
My quesiotn just is if this is true and if there are any chances that
the kernel will support that soonly.

The point is i have to trave quite some distance to my University (about
one and half an hour)
And thus doing some of my work in the train or bus. But well... they
often shake and wobble, hit the brakes suddenly and some of that stuff
which makes me nearly drop my notebook often.
Thats the most point why i would be very pleased to know that my hd
doesn't suffer a headcrash in such a circumstance.
As there are quite some notebooks out there which support this nowadays
(i know of some IBM/lenovo and HP ones), a generic support for that
would be nice and make users of linux on notebooks feel much more
comfortable.

So i hope this issue can be adressed soon. but i also know that most of
you are very busy and i can not evaluate how difficult such a change
would be. However if anyone wants to test some things or more
information, i am ready. Just CC me :)

thanks,
Christoph

