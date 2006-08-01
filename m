Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWHAQ5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWHAQ5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 12:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWHAQ5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 12:57:16 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:11708 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1751283AbWHAQ5P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 12:57:15 -0400
Message-ID: <44CF87E6.1050004@slaphack.com>
Date: Tue, 01 Aug 2006 11:57:10 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
CC: Bernd Schubert <bernd-schubert@gmx.de>, reiserfs-list@namesys.com,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, ipso@snappymail.ca,
       reiser@namesys.com, lkml@lpbproductions.com, jeff@garzik.org,
       tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
In-Reply-To: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand wrote:
> Bernd Schubert <bernd-schubert@gmx.de> wrote:

>> While filesystem speed is nice, it also would be great if reiser4.x would be 
>> very robust against any kind of hardware failures.
> 
> Can't have both.

Why not?  I mean, other than TANSTAAFL, is there a technical reason for 
them being mutually exclusive?  I suspect it's more "we haven't found a 
way yet..."
