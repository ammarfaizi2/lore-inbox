Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131157AbRDKEV5>; Wed, 11 Apr 2001 00:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRDKEVq>; Wed, 11 Apr 2001 00:21:46 -0400
Received: from odin.sinectis.com.ar ([216.244.192.158]:51717 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S131157AbRDKEVf> convert rfc822-to-8bit; Wed, 11 Apr 2001 00:21:35 -0400
Date: Wed, 11 Apr 2001 01:23:54 -0300
From: John R Lenton <john@grulic.org.ar>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010411012354.E4214@grulic.org.ar>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.17i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Tue, Apr 10, 2001 at 10:05:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 10:05:13AM -0700, Grover, Andrew wrote:
> This is not correct, because we want the power button to be configurable.
> The user should be able to redefine the power button's action, perhaps to
> only sleep the system. We currently surface button events to acpid, which
> then can do the right thing, including a shutdown -h now (which I assume
> notifies init).

Just today a friend saw my box shutdown via the powerbutton and
wondered if he coudln't set his up to trigger a different event
(actually two: he wanted his sister - the guilty party - zapped,
and a webcam shot of her face to prove it)...

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
¿Como meterán los cacahuetes dentro de la cáscara?
